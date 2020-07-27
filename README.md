# lambda

Basic untyped lambda-calculus with Parsec.

```
(variable)    => x
(abstraction) => λ(variable).(variable, abstraction, application)
(application) => (variable,abstraction)(variable,abstraction) 
```

## How to run
```
cabal v2-run
```

## Usage
Algebraic data type for lambda-calculus parser.
```hs
data Lambda = Var Char | Abs Char Lambda | App Lambda Lambda deriving Show
```
```
Var => Variable
Abs => Abstraction
App => Application
```

#### Examples
```
λ> x
Right (Var 'x')
```

```
λ> λx.x
Right (Abs 'x' (Var 'x'))
```

```
λ> λx.λy.xy
Right (Abs 'x' (Abs 'y' (App (Var 'x') (Var 'y'))))
```

```
λ> xf
Right (App (Var 'x') (Var 'f'))
```

```
λ> (λx.x)z  
Right (App (Abs 'x' (Var 'x')) (Var 'z'))
```
