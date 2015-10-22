{-# LANGUAGE OverloadedStrings #-}

module Site
  ( app
  ) where

import           Application
import           Control.Applicative
import           Data.ByteString               (ByteString)
import           ReactHaskell.Handler
import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.Heist
import           Snap.Snaplet.PostgresqlSimple
import           Snap.Util.FileServe

routes :: [(ByteString, AppHandler ())]
routes = [ ("/", method GET index)
         , ("/api/todos", method GET getTodos <|> method POST postTodo)
         , ("/assets", serveDirectory "bower_components")
         ]

app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application." Nothing $ do
    h <- nestSnaplet "heist" heist $ heistInit "templates"
    d <- nestSnaplet "db" db pgsInit
    addRoutes routes
    return $ App h d
