-- |

module ExercisesSpec where

import           Test.Hspec

spec :: Spec
spec = do

  describe "orphans" $ do

    it "does not leave orphan threads" $ do

      expectationFailure "Implement me!"

-- TODO: test listLengths Exercises.words == map length Exercises.words
