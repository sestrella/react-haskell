{-# LANGUAGE OverloadedStrings #-}

module ReactHaskell.Persistence where

import           Control.Monad
import           Database.PostgreSQL.Simple
import           ReactHaskell.Types

listTodos :: Connection -> IO [Todo]
listTodos c = query_ c "SELECT id, text FROM todos"

createTodo :: Todo -> Connection -> IO [Only Integer]
createTodo (Todo _ t) c = query c "INSERT INTO todos (text) VALUES (?) RETURNING id" (Only t)

destroyTodo :: Integer -> Connection -> IO ()
destroyTodo id c = void $ execute c "DELETE FROM todos WHERE id = ?" (Only id)

updateTodo :: Integer -> Todo -> Connection -> IO ()
updateTodo id (Todo _ t) c = void $ execute c "UPDATE todos SET text = ? WHERE id = ?" (t, id)
