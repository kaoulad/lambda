module Parser (parseLambda, Lambda (Var, Abs, App)) where

import Text.Parsec
import Text.Parsec.String (Parser)
import Control.Applicative (some)

data Lambda = Var Char | Abs Char Lambda | App Lambda Lambda deriving Show

parens' :: Parser a -> Parser a
parens' p = between (char '(') (char ')') p

factor, expr :: Parser Lambda
factor = variable <|> parens' expr
expr = abstraction <|> try application <|> factor

many2 :: Parser a -> Parser [a]
many2 p = do
          x1 <- p
          x2 <- p 
          xs <- many p
          pure $ x1:x2:xs

------------ Parsers ------------------------
variable :: Parser Lambda
variable = (Var <$> letter)

abstraction :: Parser Lambda
abstraction = do
                string "λ" <|> string "lambda:"
                f <- some letter 
                char '.'
                a <- expr
                pure $ foldr Abs a f

application :: Parser Lambda
application = do
                factors <- many2 factor
                pure (foldl1 App factors)
                
---------------------------------------------
parseLambda :: String -> Either ParseError Lambda
parseLambda exp = parse pLambda "" exp
                where pLambda = choice [abstraction,try application,variable] <?> "Syntax Error."
