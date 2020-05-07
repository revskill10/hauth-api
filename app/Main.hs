{-# LANGUAGE OverloadedStrings, NoImplicitPrelude #-}
module Main where
import System.Environment (getEnv)
import ClassyPrelude hiding (delete)
import Web.Scotty.Trans
import Network.Wai.Middleware.Cors
main :: IO ()
main = do
  
  envPort <- getEnv "PORT"
  let mayPort = readMay envPort
  case mayPort of
    Just port -> scottyT port id $ do
      middleware simpleCors
      routes
    Nothing -> putStrLn "Error"
  
routes :: (MonadIO m) => ScottyT LText m ()
routes =
  get "/hello" $ text "Hello!"