% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wmesaclient.R
\name{setAbsReference.mesa}
\alias{setAbsReference.mesa}
\title{Volta para o sistema de coordenadas absoluto.}
\usage{
\method{setAbsReference}{mesa}(dev)
}
\arguments{
\item{dev}{Um objeto de classe \code{mesa} contendo informações sobre servidor XML-RPC}
}
\description{
Volta o sistema de coordenadas para o sistema absoluto que está programado na placa
controladora.
}
\examples{
setAbsReference(dev, yref=100)

}
