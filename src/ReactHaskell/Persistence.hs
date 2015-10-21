{-# LANGUAGE OverloadedStrings #-}

module ReactHaskell.Persistence where

import Database.PostgreSQL.Simple
import ReactHaskell.Types

listTodos :: Connection -> IO [Todo]
listTodos c = query_ c "SELECT id, text FROM todos"

createTodo :: Connection -> Todo -> IO [Only Integer]
createTodo c = query c "INSERT INTO todo (text) VALUES (?) RETURNING id"
