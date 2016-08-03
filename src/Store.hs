{-# LANGUAGE ScopedTypeVariables #-}
module Store
    ( newStore
    ) where

import Data.IORef


-- Object oriented programming is based on ad-hoc polimorphism
-- A class in OO languages has two interpretation
--  * a class serves as a type
--  * a class serves as a collection of methods (things...)
-- Haskell type classes are the way how we express ad-hoc polymorphism.

-- We need a class...
class Store s where
    -- constructor
    store :: a -> IO (s a)
    -- methods
    save  :: s a -> a -> IO ()
    load  :: s a -> IO a


-- It looks like an OO object...
data StoreObj a = StoreObj {
      save_ :: a -> IO ()
    , load_ :: IO a
    }

-- It looks like a factory method...
newStore :: a -> IO (StoreObj a)
newStore x = do
    storeRef <- newIORef x

    let saveImp y = writeIORef storeRef y

    let loadImp = readIORef storeRef

    return $ StoreObj saveImp loadImp


instance Store StoreObj where
    store = newStore
    save  = save_
    load  = load_

main :: IO ()
main = do
    s :: StoreObj Int <- store 0
    save s 3
    x <- load s
    print x
