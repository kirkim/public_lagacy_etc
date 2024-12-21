const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const path = require('path');

const BASE_JS = './src/client/js/';

module.exports = {
  entry: {
    main: BASE_JS + 'main.js',
    videoPlayer: BASE_JS + 'videoPlayer.js',
    recorder: BASE_JS + 'recorder.js',
    commentSection: BASE_JS + 'commentSection.js',
  },
  //mode: 'development',
  //watch: true, // 계속해서 실행됨 nodemon맹키로 감시해줌
  plugins: [
    new MiniCssExtractPlugin({
      filename: 'css/styles.css',
    }),
  ],
  output: {
    filename: 'js/[name].js',
    path: path.resolve(__dirname, 'assets'),
    clean: true, // output folder를 build하기전에 clean해줌
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        use: {
          loader: 'babel-loader',
          options: {
            presets: [['@babel/preset-env', { targets: 'defaults' }]],
          },
        },
      },
      {
        test: /\.scss$/,
        use: [MiniCssExtractPlugin.loader, 'css-loader', 'sass-loader'], //webpack은 역순으로 실행 순서중요!
      },
    ],
  },
};
