module Msg exposing (Msg(..))

import Model exposing (Topic, Comment)
import Navigation exposing (Location)
import Http

type Msg = UrlChange Location
         | TopicsFromRemote (Result Http.Error (List Topic))
         | CommentsFromRemote (Result Http.Error (List Comment))
         | TopicNameChange String
         | PostTopic
         | PostTopicResult (Result Http.Error Topic)
         | CommentBodyChange String
         | PostComment Int
         | PostCommentResult (Result Http.Error Comment)
