module Api exposing (..)

import Model exposing (Topic, Comment)
import Msg exposing (..)
import Http
import Json.Decode as D
import Json.Encode as E
import Json.Decode.Pipeline exposing (decode, required)

decodeTopic : D.Decoder Topic
decodeTopic = decode Topic
  |> required "id" D.int
  |> required "name" D.string

decodeComment : D.Decoder Comment
decodeComment = decode Comment
  |> required "id" D.int
  |> required "topicId" D.int
  |> required "body" D.string

corsPost : String -> Http.Body -> D.Decoder a -> Http.Request a
corsPost url body decoder =
  Http.request
    { method = "POST"
    , headers = [ Http.header "Content-Type" "application/x-www-form-urlencoded" ]
    , url = url
    , body = body
    , expect = Http.expectJson decoder
    , timeout = Nothing
    , withCredentials = False
    }

endPoint : String
endPoint = "http://localhost:8080"

getTopics : Cmd Msg
getTopics =
  Http.send TopicsFromRemote
    <| Http.get (String.concat [endPoint, "/topics"])
    <| D.list decodeTopic

postTopic : String -> Cmd Msg
postTopic name =
  let
    body = Http.jsonBody <| E.object [ ("name", E.string name) ]
    url = String.concat [endPoint, "/topics"]
  in
    Http.send PostTopicResult <| corsPost url body decodeTopic

getComments : Int -> Cmd Msg
getComments topicId =
  let
    url = String.concat
      [ endPoint
      , "/topics/"
      , toString topicId
      , "/comments"
      ]
  in
    Http.send CommentsFromRemote
      <| Http.get url
      <| D.list decodeComment

postComment : Int -> String -> Cmd Msg
postComment topicId content =
  let
    body = Http.jsonBody <| E.object
      [ ("topicId", E.int topicId)
      , ("body", E.string content)
      ]

    url = String.concat
      [ endPoint
      , "/topics/"
      , toString topicId
      , "/comments"
      ]
  in
     Http.send PostCommentResult <| corsPost url body decodeComment
