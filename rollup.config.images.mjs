import { fileURLToPath } from 'url';
import path, { resolve } from 'path';
import { globSync } from 'glob';
import image from '@rollup/plugin-image';
import { defineConfig } from 'rollup';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
console.log('__dirname:', __dirname);

const dnnThemeSkinPath = 'dnn/Portals/_default/Skins';
const dnnThemeSrcPath = 'src/media';
const srcMediaPath = resolve(__dirname, dnnThemeSrcPath);
console.log('Src Media Path:', srcMediaPath);
const dnnThemeDestPath = 'AccuTheme-Tw4/dist/media';
const destMediaPath = resolve(__dirname, dnnThemeSkinPath, dnnThemeDestPath);
console.log('Dst Media Path:', destMediaPath);

// Run custom script first
import './rollup.config.images.info.js';

// Get source files with absolute paths
const imageFiles = globSync('images/**/*.{png,jpg,jpeg,gif}', {
  cwd: srcMediaPath,
}).map((file) => resolve(srcMediaPath, file));

const svgFiles = globSync('svg/**/*.svg', {
  cwd: srcMediaPath,
}).map((file) => resolve(srcMediaPath, file));

// Debug logging
console.log('Source files:', [...imageFiles, ...svgFiles]);

export default defineConfig({
  input: [...imageFiles, ...svgFiles],
  plugins: [
    image({
      dom: false,
      include: ['**/*.png', '**/*.jpg', '**/*.jpeg', '**/*.gif', '**/*.svg'],
    }),
  ],
  output: {
    dir: destMediaPath,
    assetFileNames: (assetInfo) => {
      // Parse the original path
      const parsedPath = path.parse(assetInfo.name);

      // Get the relative path from src/media
      const relativePath = assetInfo.name
        .replace(/^.*[/\\]src[/\\]media[/\\]/, '')
        .replace(/\\/g, '/');

      // Extract directory and filename components
      const directory = path.dirname(relativePath);
      const filename = path.basename(relativePath);
      const ext = path.extname(assetInfo.name);

      // Debug
      console.log('Processing:', {
        directory,
        filename,
        ext,
      });

      // Return path maintaining structure and extension
      return directory === '.' ? filename : `${directory}/${filename}`;
    },
  },
});
