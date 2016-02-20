{-# LANGUAGE OverloadedStrings #-}

module SunHypnotic where

import Web.Scotty
import Database.MongoDB
import qualified Data.Text.Lazy as T
import Control.Monad.IO.Class
import SunHypnotic.Releases


runQuery :: Pipe -> Query -> ActionM [Document]
runQuery pipe query = access pipe master "sunhypnotic" (find query >>= rest) 

serve = do
  putStrLn "Starting Server..."
  pipe <- connect $ host "127.0.0.1"
  scotty 3000 $ do
    get "/releases" $ do
      json allReleases
    get "/releases/:id" $ do
      id <- param "id"
      json (filter (matchesId id) allReleases)
    post "/releases" $ do
      release <- jsonData :: ActionM Release
      json release
    get "/mongo" $ do
      res <- runQuery pipe (select [] "releases")
      text $ T.pack $ show res