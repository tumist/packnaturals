import Data.List (elemIndex, sort)
import System.Environment (getArgs)
import Data.Maybe (fromJust)

abc = "hdOBCH8Rz~926xKW_vLAwl0Ey3aYpUPkqZ7Q4fVjFgJcXDbTum1SteInGriMs5oN"

pack :: Integral i => [i] -> String
pack n = concatMap packNum n
  where
    packNum n
        | n < 0     = error $ "Can't pack negative numbers"
        | n < 2^5   = [abc !! fromIntegral (n + 2^5)]
        | otherwise = abc !! fromIntegral (n `mod` 2^5) : packNum (n `div` 2^5)

unpack :: String -> [Integer]
unpack s = map zipGroup $ groups (fromJust mapped)
  where
    mapped = mapM (\e -> elemIndex e abc) s
    zipGroup g = sum $ zipWith (\n p -> 2^p * toInteger n) g [0,5..]
    groups [] = []
    groups ns = num : groups rest
      where
        -- span splits the list such that fst does not include the
        -- matched element, but the matched element is a part of the number
        -- that we're extracting.
        num = fst spanned ++ [head (snd spanned) - 2^5]
        rest = tail $ snd spanned
        spanned = span (<2^5) ns

packUnordered = pack . deltify . sort
  where
    deltify il = head il : zipWith subtract il (tail il)
unpackUnordered l = undeltify $ unpack l
  where
    undeltify = tail . scanl (+) 0

main = do
  args <- getArgs
  let intArgs = map (\x -> read x :: Integer) args
  let packed = packUnordered intArgs
  let unpacked = unpackUnordered packed
  putStrLn $ "packed   : " ++ packed
  putStrLn $ "unpacked : " ++ show unpacked
