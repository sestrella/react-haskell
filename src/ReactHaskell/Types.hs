{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards   #-}

module ReactHaskell.Types where

import           Data.Aeson
import           Database.PostgreSQL.Simple.FromRow
import           Database.PostgreSQL.Simple.ToField
import           Database.PostgreSQL.Simple.ToRow

data Todo = Todo
  { todoId   :: Integer
  , todoText :: String
  } deriving (Eq, Show)

instance FromRow Todo where
  fromRow = Todo <$> field <*> field

instance ToRow Todo where
  toRow Todo{..} = [toField todoId, toField todoText]

instance FromJSON Todo where
  parseJSON (Object o) = Todo <$> o .: "id" <*> o .: "text"
  parseJSON _          = mempty

instance ToJSON Todo where
  toJSON Todo{..} = object ["id" .= todoId, "text" .= todoText]
