const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
const webpack = require('webpack')
environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/src/jquery',
        jquery: 'jquery/src/jquery',
        jquery: 'jquery/src/jquery',
    })
)
environment.config.resolve.alias = {'vue$': 'vue/dist/vue.esm.js'};
module.exports = environment
