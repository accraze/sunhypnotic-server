{-# LANGUAGE OverloadedStrings #-}

module SunHypnotic where

import Web.Scotty
import SunHypnotic.Releases

serve = do
  putStrLn "Starting Server..."
  scotty 3000 $ do
    get "/releases" $ do
      json allReleases
    get "/releases/:id" $ do
      id <- param "id"
      json (filter (matchesId id) allReleases)
    post "/releases" $ do
      release <- jsonData :: ActionM Release
      json release