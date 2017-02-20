import React from 'react';
import { Route, IndexRoute } from 'react-router';
import App from './App';

import AccountPage from './pages/AccountPage';
import DocumentIndexPage from './pages/DocumentIndexPage';
import DocumentPage from './pages/DocumentPage';
import IndexPage from './pages/IndexPage';
import StyleguidePage from './pages/StyleguidePage';

export default (
  <Route path="/" component={App}>
    <IndexRoute component={IndexPage} />
    <Route path="/docs" component={DocumentIndexPage} />
    <Route path="/docs/:documentToken" component={DocumentPage} />
    <Route path="/account" component={AccountPage} />
    <Route path="/style" component={StyleguidePage} />
  </Route>
);
