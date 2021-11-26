-- No geral, operações IO em biblitoecas não são escritas
-- usando IO diretamente, mas sim usando a interface HasIO:

interface Monad io => Main.HasIO io where
  liftIO : (1 _ : IO a) -> io a

-- HasIO explica por liftIO como converter um IO primitico
-- para uma operação de um tipo subjacente, contando que
-- o tipo seja uma implementação de Monad. Essa interface
-- permite o programador a definir mais notações expressivas
-- do programa interativa, enquanto ainda possui um
-- acesso direto ao IO primitivo.