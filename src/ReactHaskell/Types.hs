{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module ReactHaskell.Types where

import Data.Aeson
import Database.PostgreSQL.Simple.FromRow

data Todo = Todo
  { todoId   :: Int
  , todoText :: String
  }

instance FromRow Todo where
  fromRow = Todo <$> field <*> field

instance ToJSON Todo where
  toJSON Todo{..} = object ["id" .= todoId, "text" .= todoText]
