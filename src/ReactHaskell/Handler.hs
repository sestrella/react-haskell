{-# LANGUAGE OverloadedStrings #-}

module ReactHaskell.Handler where

import Application
import ReactHaskell.Persistence
import Snap.Extras.JSON
import Snap.Snaplet.Heist
import Snap.Snaplet.PostgresqlSimple

index :: AppHandler ()
index = render "index"

getTodos :: AppHandler ()
getTodos = liftPG listTodos >>= writeJSON

postTodo :: AppHandler ()
postTodo = undefined
