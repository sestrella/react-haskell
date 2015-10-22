{-# LANGUAGE OverloadedStrings #-}

module ReactHaskell.Handler where

import Application
import ReactHaskell.Persistence
import Snap.Core
import Snap.Extras.CoreUtils
import Snap.Extras.JSON
import Snap.Snaplet.Heist
import Snap.Snaplet.PostgresqlSimple

index :: AppHandler ()
index = render "index"

getTodos :: AppHandler ()
getTodos = liftPG listTodos >>= writeJSON

postTodo :: AppHandler ()
postTodo = do
  todo <- reqJSON
  liftPG (createTodo todo)
  writeBS "done"

patchTodo :: AppHandler ()
patchTodo = do
  id   <- getId
  todo <- reqJSON
  liftPG (updateTodo id todo)

deleteTodo :: AppHandler ()
deleteTodo = do
  id <- getId
  liftPG (destroyTodo id)

getId :: AppHandler Integer
getId = maybeBadReq "Missing required param \"id\"" (readParam "id")
