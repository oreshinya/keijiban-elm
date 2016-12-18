module Api exposing (..)

import Model exposing (Topic)
import Msg exposing (..)
import Http
import Json.Decode exposing (Decoder, list, int, string)
import Json.Decode.Pipeline exposing (decode, required)

decodeTopic : Decoder Topic
decodeTopic = decode Topic
  |> required "id" int
  |> required "name" string

getTopics : Cmd Msg
getTopics =
  Http.send TopicsFromRemote
    <| Http.get "http://localhost:8080/topics"
    <| list decodeTopic
