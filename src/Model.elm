module Model exposing (..)

import Navigation
import Route exposing (..)

type alias Topic = { id : Int, name : String }
type alias Model =
  { history : List (Maybe Route)
  , topics : List Topic
  , getTopicsError : Maybe String
  }

initialModel : Navigation.Location -> Model
initialModel location =
  { history = [ parseRoute location ]
  , topics = []
  , getTopicsError = Nothing
  }

first : List (Maybe Route) -> Maybe Route
first history =
  case history of
    route::_ -> route
    [] -> Nothing
