# ows

[![Build Status][travis-image]][travis-url]
[![GitHub version][github-ver-image]][github-ver-url]
[![License][license-image]][license-url]

Simple observable like WeakSet

```
npm i ows
```

## Usage

```js
import OWS from 'ows';

let ows = new OWS();

ows.on(set => {});

ows.add('val'); // => emit change event
```

## Methods

### `.on(handler)`

### `.off(handler)`

### `.add(payload);`

### `.delete(payload);`

### `.has(payload);`

### `.clear(payload);`

## Contributing

1. Fork it!
2. Create your feature branch: git checkout -b my-new-feature
3. Commit your changes: git commit -am 'Add some feature'
4. Push to the branch: git push origin my-new-feature
5. Submit a pull request :D

## Test

```
npm test
```

## License

[MIT][license-url]

© sugarshin

[npm-image]: http://img.shields.io/npm/v/ows.svg
[npm-url]: https://www.npmjs.org/package/ows
[travis-image]: http://img.shields.io/travis/sugarshin/ows/master.svg?branch=master
[travis-url]: https://travis-ci.org/sugarshin/ows
[gratipay-image]: http://img.shields.io/gratipay/sugarshin.svg
[gratipay-url]: https://gratipay.com/sugarshin/
[coveralls-image]: https://coveralls.io/repos/sugarshin/ows/badge.svg
[coveralls-url]: https://coveralls.io/r/sugarshin/ows
[github-ver-image]: https://badge.fury.io/gh/sugarshin%2Fows.svg
[github-ver-url]: http://badge.fury.io/gh/sugarshin%2Fows
[license-image]: http://img.shields.io/:license-mit-blue.svg
[license-url]: http://sugarshin.mit-license.org/
[downloads-image]: http://img.shields.io/npm/dm/ows.svg
[dependencies-image]: http://img.shields.io/david/sugarshin/ows.svg
