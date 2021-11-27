-- Interfaces, assim como Records, podem ser declaradas
-- usando um contrutor definido pelo usuario

interface A a where
  getA : a

interface A t => B t where
  constructor MkB

  getB : t

-- Então MkB : A t => t -> B t
