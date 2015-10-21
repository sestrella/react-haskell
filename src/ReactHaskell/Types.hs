{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module ReactHaskell.Types where

import Data.Aeson
import Database.PostgreSQL.Simple.FromRow
import Database.PostgreSQL.Simple.ToRow
import Database.PostgreSQL.Simple.ToField

data Todo = Todo
  { todoId   :: Integer
  , todoText :: String
  } deriving (Eq, Show)

instance FromRow Todo where
  fromRow = Todo <$> field <*> field

instance ToRow Todo where
  toRow Todo{..} = [toField todoId, toField todoText]

instance FromJSON Todo where
  parseJSON = undefined

instance ToJSON Todo where
  toJSON Todo{..} = object ["id" .= todoId, "text" .= todoText]
