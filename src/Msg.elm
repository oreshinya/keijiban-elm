module Msg exposing (Msg(..))

import Model exposing (Topic)
import Navigation exposing (Location)
import Http

type Msg = UrlChange Location
         | TopicsFromRemote (Result Http.Error (List Topic))
