const CompressionPlugin = require('compression-webpack-plugin');

module.exports = {
  productionSourceMap: false,
  lintOnSave: process.env.NODE_ENV !== 'production',
  chainWebpack(config) {
    config.plugins.delete('prefetch');
    config.plugin('CompressionPlugin').use(CompressionPlugin);
  },
};
