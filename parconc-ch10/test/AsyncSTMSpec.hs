{-# LANGUAGE DeriveDataTypeable #-}
-- |

module AsyncSTMSpec where

import           AsyncSTM
import           Control.Exception
import           Data.Typeable
import           Test.Hspec

data Ch10Exception = Ch10Exception String
  deriving (Typeable, Show)

instance Exception Ch10Exception

boom :: IO a
boom = throw (Ch10Exception "boom")

withMessage :: String -> Selector Ch10Exception
withMessage s (Ch10Exception str)  = s == str

spec :: Spec
spec = do
  describe "async" $ do
    it "performs actions asynchronously and allows to wait for their results" $ do
      let str0 = "hello "
          str1 = " async world"
      a0 <- async $ return str0
      a1 <- async $ return str1
      r0 <- wait a0
      r1 <- wait a1
      r0 ++ r1 `shouldBe` str0 ++ str1

    it "allows to perform wait multiple times" $ do
      let str = "hello"
      a <- async $ return str
      r0 <- wait a
      r1 <- wait a
      r0 ++ r1 `shouldBe` str ++ str

    it "propagates exceptions to the waiting thread" $ do
      (do
          a <- async $ boom
          wait a
        )
      `shouldThrow` (withMessage "boom")
