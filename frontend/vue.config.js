const CompressionPlugin = require('compression-webpack-plugin');
const PurgecssPlugin = require('purgecss-webpack-plugin');
const glob = require('glob-all');
const path = require('path');

module.exports = {
  productionSourceMap: false,
  lintOnSave: process.env.NODE_ENV !== 'production',
  chainWebpack(config) {
    config.plugins.delete('prefetch');
    config.plugin('CompressionPlugin').use(CompressionPlugin);
  },
  css: {
    extract: {
      filename: '[name].css',
    },
  },
  configureWebpack: {
    plugins: [
      new PurgecssPlugin({
        paths: glob.sync([
          path.join(__dirname, './node_modules/buefy/**/*.@(vue|js)'),
          path.join(__dirname, './public/index.html'),
          path.join(__dirname, './src/**/*.@(vue|js)'),
        ]),
        // whitelistPatterns: [/^navbar-/, /^has-text-/, /^fa-/, /^has-numberinput-/]
        whitelistPatterns: [/^navbar-/, /^has-numberinput-/, /^ml-/],
      }),
    ],
    optimization: {
      splitChunks: {
        chunks: 'all',
        cacheGroups: {
          styles: {
            name: 'styles',
            test: /\.css$/,
            chunks: 'all',
            enforce: true,
          },
        },
      },
    },
  },
};
