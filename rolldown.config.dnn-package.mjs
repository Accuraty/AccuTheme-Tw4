import { defineConfig } from 'rolldown';

export default defineConfig(() => {
  throw new Error(
    [
      'dnn-package is not implemented yet for Rolldown.',
      'No previous rollup.config.dnn-package.js exists in this repository.',
      'Next step: port the package zip workflow into rolldown.config.dnn-package.mjs or a dedicated PowerShell script.',
    ].join(' ')
  );
});
