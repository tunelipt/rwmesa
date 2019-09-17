require(XMLRPC)
require(abstractmov)

#' Criar conexão com a mesa giratório do túnel de vento do IPT
#'
#' Cria um objeto de classe \code{mesa} que controla a comunicação com
#' o servidor XML-RPC da mesa giratória do túnel de vento do IPT.
#' 
#' @param url String com URL do servidor XML-RPC
#' @param port Inteiro com o número da porta TCP/IP usado pelo XML-RPC
#' @return Um objeto de classe \code{mesa}
#' @examples
#' dev <- mesaDev()
#' 
#' @export
mesaDev <- function(url='localhost', port=9596){

    url1 <- paste0(url, ":", port)
    rpc <- function(cmd, ...) xml.rpc(url1, cmd, ...)
    dev <- list(url=url, port=port, rpc=rpc)
    class(dev) <- 'mesa'
    return(dev)
}

#' Gira a mesa do túnel de vento do IPT.
#'
#' Gira a mesa do túnel de vento do ipt. Valores positivos do ângulo de rotação
#' resultam em movimento no sentido anti-horário.
#'
#' @param dev Um objeto de classe \code{mesa} contendo informações sobre servidor XML-RPC
#' @param x Número informando o ângulo em graus que se deseja girar
#' @param a TRUE/FALSE, informa se o movimento se dá na referência absoluta ou relativa
#' @param r TRUE/FALSE, movimento relativo em relação ao ponto atual?
#' @param @sync TRUE/FALSE Se sincronizado, a função só retorna depois de executado o movimento
#'
#' @examples
#' move(dev, 5, r=TRUE)
#'
#' @export
move.mesa <- function(dev, x, a=FALSE, r=FALSE, sync=FALSE){
    dev$rpc("move", x, a, r, sync)
}


#' Movimento relativo da mesa giratória
#'
#' Gira a mesa em relação à posição atual. Valores positivos de giro correspondem ao
#' sentido anti-horário.
#'
#' @param dev Um objeto de classe \code{mesa} contendo informações sobre servidor XML-RPC
#' @param x Número informando o ângulo que se deseja girar a mesa
#' @param @sync TRUE/FALSE Se sincronizado, a função só retorna depois de executado o movimento
#'
#' @examples
#' rmove(dev, 5)
#'
#' @export
rmove.mesa <- function(dev, x, sync=FALSE){
    dev$rpc("move", x, FALSE, TRUE,sync)
}



#' Posição no sistema de referência abosluto
#'
#' Retorna a posição da mesa giratória no sistema de referência absoluto.
#' O sistema de referência absoluto é o que está na placa controladora da mesa giratória
#'
#' @param dev Um objeto de classe \code{mesa} contendo informações sobre servidor XML-RPC
#' @return Lista contendo o ângulo da mesa
#' @examples
#' absPosition(dev)
#'
#' @export
absPosition.mesa <- function(dev){
    dev$rpc("abs_position")
}

#' Posição da mesa giratória
#'
#' Retorna a posição da mesa giratória no sistema de referência relativo.
#' O sistema de referência absoluto é o que está na placa controladora da mesa giratória.
#'
#' @param dev Um objeto de classe \code{mesa} contendo informações sobre servidor XML-RPC
#' @return Lista contendo o ângulo
#'
#' @examples
#' position(dev)
#'
#' @export
position.mesa <- function(dev){
    dev$rpc("position")
}

#' Cria novo sistema de referência
#'
#' Configura um novo sistema de referência onde a posição atual da mesa giratória tem
#' valore \code{xref}. Este sistema de referência relativo
#' tem a mesma orientação que o sistema de placa controladora. O que muda é a origem.
#'
#' @param dev Um objeto de classe \code{mesa} contendo informações sobre servidor XML-RPC
#' @param xref Valor que a coordenada x atual toma.
#' 
#' @examples
#' setReference(dev, 100)
#' 
#' @export
setReference.mesa <- function(dev, xref=0){
    dev$rpc("set_reference", xref)
}


#' Volta para o sistema de coordenadas absoluto.
#'
#' Volta o sistema de coordenadas para o sistema absoluto que está programado na placa
#' controladora.
#'
#' @param dev Um objeto de classe \code{mesa} contendo informações sobre servidor XML-RPC
#'
#' @examples
#' setAbsReference(dev, yref=100)
#' 
#' @export
setAbsReference.mesa <- function(dev){
    dev$rpc("set_abs_reference")
}



#' Espere o movimento terminar
#'
#' A maioria dos comandos de movimentação da mesa giratória são assíncronos. O comando é dado e o programa
#' volta para o programador (usuário) imediatamente enquanto o movimento se realiza. Várias funções
#' têm o argumento \code{sync} que torna o comando síncrono. Mas no caso geral, esta função vai
#' simplesmente esperar que qualquer movimento programado termine antes de retornar o controle.
#' 
#' @param dev Um objeto de classe \code{mesa} contendo informações sobre servidor XML-RPC
#'
#' @examples
#' move(dev, 45, sync=FALSE)
#' waitUntilDone(dev)
#' 
#' @export
waitUntilDone.mesa <- function(dev){
    dev$rpc("waitUntilDone")
}

#' Paramada imediata
#'
#' Envia comando para a mesa giratória para qualquer movimento.
#'
#' @param dev Um objeto de classe \code{mesa} contendo informações sobre servidor XML-RPC
#'
#' @examples
#' move(dev, 30)
#' stopnow(dev)
#'
#' @export
stopnow.mesa <- function(dev){
    dev$rpc("stop")
}



    
        
