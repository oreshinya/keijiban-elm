module Api exposing (..)

import Model exposing (Topic, Comment)
import Msg exposing (..)
import Http
import Json.Decode exposing (Decoder, list, int, string)
import Json.Decode.Pipeline exposing (decode, required)

decodeTopic : Decoder Topic
decodeTopic = decode Topic
  |> required "id" int
  |> required "name" string

decodeComment : Decoder Comment
decodeComment = decode Comment
  |> required "id" int
  |> required "topicId" int
  |> required "body" string

endPoint : String
endPoint = "http://localhost:8080"

getTopics : Cmd Msg
getTopics =
  Http.send TopicsFromRemote
    <| Http.get (String.concat [endPoint, "/topics"])
    <| list decodeTopic

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
      <| list decodeComment
