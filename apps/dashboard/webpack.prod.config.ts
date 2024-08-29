import { withModuleFederation } from '@nx/angular/module-federation';
import config from './module-federation.config';

export default withModuleFederation({
  ...config,
  remotes: [
    ['login', 'http://localhost:8080'], // Replace with the actual URL where your remote app is deployed
    // Add more remotes as needed
  ],
});