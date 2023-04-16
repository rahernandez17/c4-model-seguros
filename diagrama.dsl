!constant API_TEC "Spring"
!constant API_INTERNAL_TEC "Java 17"
!constant SPA_TEC "Angular 15"
!constant BD_TEC "PostgreSQL 15"
!constant AWS_TEC "Cloud"


workspace \
    "C4 Sistema de seguros" \
    "Diagrama que describe las diferentes vistas del sistema de seguros usando el modelo C4" \
{
    model {
        # Elementos
        corredor = person \
            "Corredor de seguros" \
            "Usuario que realizará cotizaciones y presentará propuestas al cliente con base en las comparaciones de cotizaciones"
            
        cliente = person \
            "Cliente" \
            "Usuario que cotizó y/o adquirió un seguro y diligenciará las encuestas que se habiliten en el sistema"
        
        administrador = person \
            "Administrador" \
            "Usuario que administrará los demás usuarios del sistema"
        
        segurosSystem = softwareSystem \
            "Sistema de seguros" \
            "Sistema encargado de realizar planes de pago, cotizaciones de seguros y presentar las mejores opciones al cliente" \
        {
            # Microfronts
            mfAutenticacionContainer = container \
                "MicroFrontend Autenticación" \
                "Aplicación web encargada de la autenticación de los usuarios en el sistema" \
                "${SPA_TEC}" \
                "mf-autenticacion" \
            {
                mfAuthComponentComponent = component \
                    "AutenticacionComponent" \
                    "Páginas web para inicio de sesión" \
                    "${SPA_TEC}"

                mfAuthServiceComponent = component \
                    "AutenticacionService" \
                    "Realiza las peticiones al microservicio de autenticación" \
                    "${SPA_TEC}"

                mfAuthRoutingComponent = component \
                    "AutenticacionRouting" \
                    "Enruta las páginas web de autenticación" \
                    "${SPA_TEC}"

                mfAuthGuardComponent = component \
                    "AutenticacionGuard" \
                    "Permite/bloquea acceso a ciertas páginas de autenticación" \
                    "${SPA_TEC}"
            }
            
            mfCotizacionesContainer = container \
                "MicroFrontend Cotizaciones" \
                "Aplicación web encargada de las cotizaciones a las aseguradoras y comparaciones de los seguros" \
                "${SPA_TEC}" \
                "mf-cotizaciones" \
            {
                mfCotizacionComponentComponent = component \
                    "CotizacionComponent" \
                    "Página web para ingresar las cotizaciones" \
                    "${SPA_TEC}"
                
                mfCotizacionServiceComponent = component \
                    "CotizacionService" \
                    "Realiza las peticiones al microservicio de cotizaciones" \
                    "${SPA_TEC}"

                mfCotizacionRoutingComponent = component \
                    "CotizacionRouting" \
                    "Enruta las páginas web de cotizaciones" \
                    "${SPA_TEC}"

                mfCotizacionGuardComponent = component \
                    "CotizacionGuard" \
                    "Permite/bloquea acceso a ciertas páginas de cotizaciones" \
                    "${SPA_TEC}"

                mfCompararComponentComponent = component \
                    "CompararComponent" \
                    "Páginas web para comparar cotizaciones de seguros" \
                    "${SPA_TEC}"

                mfCompararServiceComponent = component \
                    "CompararService" \
                    "Realiza las peticiones al microservicio de cotizaciones" \
                    "${SPA_TEC}"

                mfCompararRoutingComponent = component \
                    "CompararRouting" \
                    "Enruta las páginas web de comparación" \
                    "${SPA_TEC}"

                mfCompararGuardComponent = component \
                    "CompararGuard" \
                    "Permite/bloquea acceso a ciertas páginas de comparación" \
                    "${SPA_TEC}"
            }

            mfEncuestasContainer = container \
                "MicroFrontend Encuestas" \
                "Aplicación web encargada de permitir la realización de encuestas: venta, renovación, reclamación de póliza" \
                "${SPA_TEC}" \
                "mf-encuestas"

            mfFinanciacionContainer = container \
                "MicroFrontend Financiación" \
                "Aplicación web encargada de los planes de pago y, en un futuro, todo el tema de pagos." \
                "${SPA_TEC}" \
                "mf-financiacion"

            mfCampaniasContainer = container \
                "MicroFrontend Campañas" \
                "Aplicación web encargada de las campañas de renovación de seguros" \
                "${SPA_TEC}" \
                "mf-campanias"

            mfUsuariosContainer = container \
                "MicroFrontend Usuarios" \
                "Aplicación web encargada de la gestión de usuarios del sistema" \
                "${SPA_TEC}" \
                "mf-usuarios"
            
            #Microservices
            msNotificacionesContainer = container \
                "Microservicio Notificaciones" \
                "Servicio encargado del envío de emails como notificaciones. En un futuro se puede añadir otros tipos de notificación" \
                "${API_TEC}" \
            {
                notiControllerComponent = component \
                    "NotificacionController" \
                    "Expone endpoints para enviar notificaciones" \
                    "${API_INTERNAL_TEC}"
                    
                notiServiceComponent = component \
                    "NotificacionService" \
                    "Expone lógica de negocio para enviar notificaciones" \
                    "${API_INTERNAL_TEC}"

                notiFacadeComponent = component \
                    "NotificacionProviderRepository" \
                    "Realiza peticiones a AWS SES para enviar notificaciones" \
                    "${API_INTERNAL_TEC}"
            }

            msAutenticacionContainer = container \
                "Microservicio Autenticación" \
                "Servicio encargado de la autenticiación de los usuarios al sistema" \
                "${API_TEC}" \
            {
                authControllerComponent = component \
                    "AutenticacionController" \
                    "Expone endpoints para autenticar usuarios" \
                    "${API_INTERNAL_TEC}"

                authServiceComponent = component \
                    "AutenticacionService" \
                    "Expone lógica de negocio para autenticar usuarios" \
                    "${API_INTERNAL_TEC}"

                authRepositoryComponent = component \
                    "AutenticacionRepository" \
                    "Realiza transacciones en la base de datos" \
                    "${API_INTERNAL_TEC}"

                authFacadeComponent = component \
                    "AutenticacionProviderRepository" \
                    "Realiza peticiones a AWS Cognito autenticar usuarios" \
                    "${API_INTERNAL_TEC}"
            }

            msCotizacionesContainer = container \
                "Microservicio Cotizaciones" \
                "Servicio encargado de la creación y realización de cotizaciones a las aseguradoras. También se encarga de comparar las cotizaciones" \
                "${API_TEC}" \
            {
                cotizacionControllerComponent = component \
                    "CotizacionController" \
                    "Expone endpoints para gestionar las cotizaciones a aseguradoras" \
                    "${API_INTERNAL_TEC}"

                cotizacionServiceComponent = component \
                    "CotizacionService" \
                    "Expone lógica de negocio para gestionar las cotizaciones a aseguradoras" \
                    "${API_INTERNAL_TEC}"

                cotizacionRepositoryComponent = component \
                    "CotizacionRepository" \
                    "Realiza transacciones en la base de datos" \
                    "${API_INTERNAL_TEC}"

                cotizacionFacadeComponent = component \
                    "CotizacionProviderRepository" \
                    "Realiza peticiones a las API de las asegguradoras para solicitar cotizaciones" \
                    "${API_INTERNAL_TEC}"
                
                comparacionControllerComponent = component \
                    "ComparacionController" \
                    "Expone endpoints relacionados con comparación de cotizaciones" \
                    "${API_INTERNAL_TEC}"

                comparacionServiceComponent = component \
                    "ComparacionService" \
                    "Expone lógica de negocio para comparar cotizaciones" \
                    "${API_INTERNAL_TEC}"

                comparacionRepositoryComponent = component \
                    "ComparacionRepository" \
                    "Realiza transacciones en la base de datos" \
                    "${API_INTERNAL_TEC}"
                
                notificacionServiceComponent = component \
                    "NotificacionService" \
                    "Expone lógica de negocio para enviar notificaciones" \
                    "${API_INTERNAL_TEC}"

                notificacionFacadeComponent = component \
                    "NotificacionProviderRepository" \
                    "Realiza peticiones al Micro Ssrvicio de notificaciones" \
                    "${API_INTERNAL_TEC}"
            }
            
            msEncuestasContainer = container \
                "Microservicio Encuestas" \
                "Servicio encargado de las gestión de encuestas para los clientes" \
                "${API_TEC}"

            msFinanciacionContainer = container \
                "Microservicio Financiación" \
                "Servicio encargado de la generación de planes de pago. En un futuro se puede añadir el tema de pagos" \
                "${API_TEC}"

            msCampaniasContainer = container \
                "Microservicio Campañas" \
                "Servicio encargado de la gestión de las campañas de renovación de seguros" \
                "${API_TEC}"

            msUsuariosContainer = container \
                "Microservicio Usuarios" \
                "Servicio encargado de la gestión de usuarios del sistema" \
                "${API_TEC}"
            
            #Base de datos
            bdContainer = container \
                "Base de datos Sistema seguros" \
                "Almacena toda la información respecto a seguros y cotizaciones" \
                "${BD_TEC}" \
                "bd-sistema"
        }
        
        awsSystem = softwareSystem \
            "AWS Servicios" \
            "Servicios de computación en la nube" \
            "aws-servicios" \
        {
            awsSESContainer = container \
                "Amazon Simple Email Service" \
                "Servicio de AWS encargado del envío de emails" \
                "${AWS_TEC}" \
                "aws-ses"
            
            awsCognitoContainer = container \
                "Amazon Cognito" \
                "Servicio de AWS encargado de la autenticación de los usuarios del sistema" \
                "${AWS_TEC}" \
                "aws-cognito"
        }
        
        aseguradorasAPISystem = softwareSystem \
            "API's de aseguradoras" \
            "API's proporcionadas por las aseguradoras para realizar cotizaciones" \
            "api-aseguradoras"
        
        # Relaciones

        # Context
        corredor -> segurosSystem "Solicita y compara cotizaciones, y envía propuestas usando"
        cliente -> segurosSystem "Realiza encuestas usando"
        administrador -> segurosSystem "Administra usuarios usando"
        segurosSystem -> aseguradorasAPISystem "Obtiene cotizaciones de seguros usando"
        segurosSystem -> awsSystem "Utiliza servicios de computación en la nube a través de"
        
        # Containers
        corredor -> mfCotizacionesContainer "Usa a" "HTTPS"
        corredor -> mfFinanciacionContainer "Usa a" "HTTPS"
        corredor -> mfCampaniasContainer "Usa a" "HTTPS"
        corredor -> mfAutenticacionContainer "Usa a" "HTTPS"
        cliente -> mfEncuestasContainer "Usa a" "HTTPS"
        cliente -> mfAutenticacionContainer "Usa a" "HTTPS"
        administrador -> mfUsuariosContainer "Usa a" "HTTPS"
        administrador -> mfAutenticacionContainer "Usa a" "HTTPS"
    
        mfCotizacionesContainer -> msCotizacionesContainer "Realiza peticiones y recibe respuestas de" "JSON/HTTPS"
        mfEncuestasContainer -> msEncuestasContainer "Realiza peticiones y recibe respuestas de" "JSON/HTTPS"
        mfFinanciacionContainer -> msFinanciacionContainer "Realiza peticiones y recibe respuestas de" "JSON/HTTPS"
        mfCampaniasContainer -> msCampaniasContainer "Realiza peticiones y recibe respuestas de" "JSON/HTTPS"
        mfUsuariosContainer -> msUsuariosContainer "Realiza peticiones y recibe respuestas de" "JSON/HTTPS"
        mfAutenticacionContainer -> msAutenticacionContainer "Realiza peticiones y recibe respuestas de" "JSON/HTTPS"
        msCotizacionesContainer -> bdContainer "Lee y escribe en" "JDBC" "r-ms-bd-1"
        msFinanciacionContainer -> bdContainer "Lee y escribe en" "JDBC" "r-ms-bd-2"
        msCampaniasContainer -> bdContainer "Lee y escribe en" "JDBC" "r-ms-bd-3"
        msUsuariosContainer -> bdContainer "Lee y escribe en" "JDBC" "r-ms-bd-4"
        msAutenticacionContainer -> bdContainer "Lee y escribe en" "JDBC" "r-ms-bd-5"
        msEncuestasContainer -> bdContainer "Lee y escribe en" "JDBC" "r-ms-bd-6"
        msNotificacionesContainer -> awsSESContainer "Usa a" "TCP/IP" "r-ms-aws-1"
        msAutenticacionContainer -> awsCognitoContainer "Usa a" "TCP/IP" "r-ms-aws-2"
        msCotizacionesContainer -> aseguradorasAPISystem "Hace llamados API a" "XML/JSON"
        msCotizacionesContainer -> msNotificacionesContainer "Usa a" "TCP/IP"
        msCampaniasContainer -> msNotificacionesContainer "Usa a" "TCP/IP"
 
        #Components
        msCotizacionesContainer -> notiControllerComponent "Realiza peticiones a"
        msCampaniasContainer -> notiControllerComponent "Realiza peticiones a"
        notiControllerComponent -> notiServiceComponent "Usa a"
        notiServiceComponent -> notiFacadeComponent "Usa a"
        notiFacadeComponent -> awsSESContainer "Usa a"
        
        mfAutenticacionContainer -> authControllerComponent "Realiza peticiones a"
        authControllerComponent -> authServiceComponent "Usa a"
        authServiceComponent -> authRepositoryComponent "Usa a"
        authServiceComponent -> authFacadeComponent "Usa a"
        authRepositoryComponent -> bdContainer "Usa a"
        authFacadeComponent -> awsCognitoContainer "Usa a"

        mfCotizacionesContainer -> cotizacionControllerComponent "Realiza peticiones a"
        cotizacionControllerComponent -> cotizacionServiceComponent "Usa a"
        cotizacionServiceComponent -> cotizacionRepositoryComponent "Usa a"
        cotizacionServiceComponent -> cotizacionFacadeComponent "Usa a"
        cotizacionFacadeComponent -> aseguradorasAPISystem "Usa a"
        cotizacionRepositoryComponent -> bdContainer "Usa a"
        mfCotizacionesContainer -> comparacionControllerComponent "Realiza peticiones a"
        comparacionControllerComponent -> comparacionServiceComponent "Usa a"
        comparacionServiceComponent -> comparacionRepositoryComponent "USa a"
        comparacionRepositoryComponent -> bdContainer "Usa a"
        comparacionServiceComponent -> notificacionServiceComponent "Usa a"
        notificacionServiceComponent -> notificacionFacadeComponent "Usa a"
        notificacionFacadeComponent -> notiControllerComponent "Usa a"
        
        corredor -> mfAuthRoutingComponent "Usa a"
        cliente -> mfAuthRoutingComponent "Usa a"
        administrador -> mfAuthRoutingComponent "Usa a"
        mfAuthRoutingComponent -> mfAuthComponentComponent "Usa a"
        mfAuthRoutingComponent -> mfAuthGuardComponent "Usa a"
        mfAuthComponentComponent -> mfAuthServiceComponent "Usa a"
        mfAuthServiceComponent -> authControllerComponent "Usa a"

        corredor -> mfCotizacionRoutingComponent "Usa a"
        mfCotizacionRoutingComponent -> mfCotizacionComponentComponent "Usa a"
        mfCotizacionRoutingComponent -> mfCotizacionGuardComponent "Usa a"
        mfCotizacionComponentComponent -> mfCotizacionServiceComponent "Usa a"
        mfCotizacionServiceComponent -> cotizacionControllerComponent "Usa a"

        corredor -> mfCompararRoutingComponent "Usa a"
        mfCompararRoutingComponent -> mfCompararComponentComponent "Usa a"
        mfCompararRoutingComponent -> mfCompararGuardComponent "Usa a"
        mfCompararComponentComponent -> mfCompararServiceComponent "Usa a"
        mfCompararServiceComponent -> cotizacionControllerComponent "Usa a"
    }

    views {
        systemContext segurosSystem "contexto-sistema" {
            include *
            autoLayout tb
        }
        
        container segurosSystem "container-sistema" {
            include corredor cliente administrador aseguradorasAPISystem bdContainer
            include mfCotizacionesContainer  mfEncuestasContainer mfFinanciacionContainer
            include mfCampaniasContainer mfUsuariosContainer mfAutenticacionContainer
            include msCotizacionesContainer msFinanciacionContainer msCampaniasContainer msUsuariosContainer
            include msAutenticacionContainer msEncuestasContainer msNotificacionesContainer
            include awsSESContainer awsCognitoContainer
            autoLayout tb
        }

        
        component msNotificacionesContainer "component-ms-notificaciones" {
            include *
            autoLayout lr
        }
        
        component msAutenticacionContainer "component-ms-autenticacion" {
            include *
            autoLayout lr
        }

        component msCotizacionesContainer "component-ms-cotizaciones" {
            include *
            autoLayout lr
        }

        component mfAutenticacionContainer "component-mf-autenticacion" {
            include corredor cliente administrador
            include mfAuthRoutingComponent mfAuthComponentComponent mfAuthGuardComponent mfAuthServiceComponent
            include authControllerComponent
            autoLayout lr
        }

        component mfCotizacionesContainer "component-mf-cotizaciones" {
            include corredor
            include mfCotizacionRoutingComponent mfCotizacionComponentComponent
            include mfCotizacionGuardComponent mfCotizacionServiceComponent
            include mfCompararRoutingComponent mfCompararComponentComponent
            include mfCompararGuardComponent mfCompararServiceComponent
            include cotizacionControllerComponent
            autoLayout lr
        }
        
        styles {
            element "api-aseguradoras" {
                background gray
            }
            
            element "aws-servicios" {
                background red
            }
            
            element "mf-cotizaciones" {
                shape WebBrowser
            }

            element "mf-encuestas" {
                shape WebBrowser
            }

            element "mf-financiacion" {
                shape WebBrowser
            }

            element "mf-campanias" {
                shape WebBrowser
            }

            element "mf-usuarios" {
                shape WebBrowser
            }

            element "mf-autenticacion" {
                shape WebBrowser
            }
            
            element "bd-sistema" {
                shape Cylinder
            }
            
            element "aws-ses" {
                background red
            }

            element "aws-cognito" {
                background red
            }

            relationship "r-ms-bd-1" {
                color blue
            }

            relationship "r-ms-bd-2" {
                color blue
            }

            relationship "r-ms-bd-3" {
                color blue
            }

            relationship "r-ms-bd-4" {
                color blue
            }

            relationship "r-ms-bd-5" {
                color blue
            }

            relationship "r-ms-bd-6" {
                color blue
            }

            relationship "r-ms-aws-1" {
                color red
            }

            relationship "r-ms-aws-2" {
                color red
            }
        }
        
        theme default
    }
}