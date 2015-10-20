{-# LANGUAGE OverloadedStrings #-}

------------------------------------------------------------------------------
-- | This module is where all the routes and handlers are defined for your
-- site. The 'app' function is the initializer that combines everything
-- together and is exported by this module.
module Site
  ( app
  ) where

------------------------------------------------------------------------------
import           Control.Applicative
import           Data.ByteString (ByteString)
import           Data.Monoid
import           Heist
import           Snap.Core
import           Snap.Snaplet
import           Snap.Snaplet.Heist
import           Snap.Snaplet.PostgresqlSimple
import           Snap.Util.FileServe
import qualified Data.Text as T
import qualified Heist.Interpreted as I
------------------------------------------------------------------------------
import           Application
import           ReactHaskell.Handler

------------------------------------------------------------------------------
-- | The application's routes.
routes :: [(ByteString, Handler App App ())]
routes = [ ("/", method GET index)
         , ("/api/todos", method GET getTodos)
         , ("/assets", serveDirectory "bower_components")
         ]


------------------------------------------------------------------------------
-- | The application initializer.
app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application." Nothing $ do
    h <- nestSnaplet "heist" heist $ heistInit "templates"
    d <- nestSnaplet "db" db pgsInit
    addRoutes routes
    return $ App h d

