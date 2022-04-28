// Application resources declares dependencies for ui using grails plugins
modules = {
    core {
        dependsOn 'jquery, jquery-ui'
    }

    uploadr{
        dependsOn 'jquery, jquery-ui'

    }

}