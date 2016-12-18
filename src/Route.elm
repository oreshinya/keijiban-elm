module Route exposing (Route(..), parseRoute)

import Navigation
import UrlParser exposing (Parser, parseHash, top, (</>), s, int, oneOf, map)

type Route = IndexTopic | ShowTopic Int

route : Parser (Route -> a) a
route = oneOf [ map IndexTopic top, map ShowTopic (s "topics" </> int) ]

parseRoute : Navigation.Location -> Maybe Route
parseRoute location = parseHash route location
