module Model exposing (..)

import Navigation
import Route exposing (..)

type alias Topic = { id : Int, name : String }
type alias Comment = { id : Int, topicId: Int, body : String }
type alias Model =
  { history : List (Maybe Route)
  , topics : List Topic
  , getTopicsError : Maybe String
  , comments : List Comment
  , getCommentsError : Maybe String
  , topicName : String
  , postTopicError : Maybe String
  , commentBody : String
  , postCommentError : Maybe String
  }

initialModel : Navigation.Location -> Model
initialModel location =
  { history = [ parseRoute location ]
  , topics = []
  , getTopicsError = Nothing
  , comments = []
  , getCommentsError = Nothing
  , topicName = ""
  , postTopicError = Nothing
  , commentBody = ""
  , postCommentError = Nothing
  }

first : List (Maybe Route) -> Maybe Route
first history =
  case history of
    route::_ -> route
    [] -> Nothing
