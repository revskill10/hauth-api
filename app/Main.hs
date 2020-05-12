{-# LANGUAGE OverloadedStrings, NoImplicitPrelude #-}
module Main where
import System.Environment (getEnv)
import ClassyPrelude hiding (delete)
import Web.Scotty.Trans
import Network.Wai.Middleware.Cors
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.URL
import qualified Data.Text as T
defaultPort = 3000
main :: IO ()
main = do
  envPort <- getEnv "PORT"
  connectInfoEnv <- getEnv "DATABASE_URL"
  let connectInfo = parseDatabaseUrl connectInfoEnv
  let mayPort =  readMay envPort
  case mayPort of
    Just port -> scottyT port id $ do
      middleware simpleCors
      case connectInfo of
        Nothing -> notFound (text "Error leu leu")
        Just conn -> routes conn
    Nothing -> error "Error"
  
routes :: (MonadIO m) => ConnectInfo -> ScottyT LText m ()
routes conn =
  get "/hello" $ text (pack $ show conn)

