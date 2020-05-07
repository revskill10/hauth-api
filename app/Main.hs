{-# LANGUAGE OverloadedStrings, NoImplicitPrelude #-}
module Main where
import System.Environment (getEnv)
import ClassyPrelude hiding (delete)
import Web.Scotty.Trans
main :: IO ()
main = do
  envPort <- getEnv "PORT"
  let mayPort = readMay envPort
  case mayPort of
    Just port -> scottyT port id routes
    Nothing -> putStrLn "Error"
  
routes :: (MonadIO m) => ScottyT LText m ()
routes =
  get "/hello" $ text "Hello!"