{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module SunHypnotic where

import Web.Scotty
import GHC.Generics
import Data.Monoid ((<>))
import Data.Aeson (FromJSON, ToJSON)

data Release = Release {   releaseId :: String
                         , releaseName :: String
                         , artistName :: String
                         , image :: String
                         , description :: String } 
  deriving (Show, Generic)

instance ToJSON Release
instance FromJSON Release

groonz :: Release
groonz = Release { releaseId = "SH022"
                 , releaseName = "GR00NZ EP"
                 , artistName = "AC GRÜNS"
                 , image = "https://f1.bcbits.com/img/a3139046609_16.jpg"
                 , description = "Recorded in the soggy torrential rains of Portland, OR, Grüns has developed a laid-back, psychedelic landscape blending organic kicks, claps and lush orchestration alongside pulsating synths and distorted bass lines. Ripping off elements of Deep House, Broken Beat, Techno and Ambient and melting them into an amphibious affair trapped beneath the ice of winter, GR00NZ EP is sure to get heads nodding and toes tapping." }

disappear :: Release
disappear = Release { releaseId = "SH021"
                 , releaseName = "Disappear"
                 , artistName = "DONOSTIA"
                 , image = "https://f1.bcbits.com/img/a0332322986_16.jpg"
                 , description = "ACCEPT WHAT IS OFFERED AND FEEL YOUR WAY THROUGH THE CAVERNS OF YOUR OWN DECAY...\"Disappear\" sets the stage for a new take on lofi diy synth pop. Blending a natural aesthetic with the cold iron pulse of synths & drum machines, DONOSTIA's theatrical vocal delivery hints at a new era of foreboding pop classics." }

allReleases :: [Release]
allReleases = [groonz, disappear]

matchesId :: String -> Release -> Bool
matchesId id release = releaseId release == id

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