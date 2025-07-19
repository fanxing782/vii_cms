import { tanstackRouter } from '@tanstack/router-plugin/vite'
import { defineConfig } from 'vite'
import tsConfigPaths from 'vite-tsconfig-paths'
import viteReact from '@vitejs/plugin-react'
import { resolve } from 'node:path'

export default defineConfig({
  server: {
    port: 3000,
    open: true,
  },
  appType: 'spa',
  // base: '/static',
  plugins: [
    tsConfigPaths({
      projects: ['./tsconfig.json'],
    }),
    tanstackRouter({
      target: 'react',
      routesDirectory: resolve(import.meta.dirname, 'src/pages'),
      generatedRouteTree: resolve(import.meta.dirname, 'src/router', 'router.gen.ts'),
      // quoteStyle: 'double',
      semicolons: true,
      disableTypes: false,
      addExtensions: false,
      disableLogging: false,
      routeFileIgnorePattern: 'components',
      indexToken: 'index',
      routeToken: 'route',
      enableRouteGeneration: true,
      autoCodeSplitting: true,
      routeTreeFileHeader: [
        '/* eslint-disable */',
        '// @ts-nocheck',
        '// noinspection JSUnusedGlobalSymbols',
      ],
    }),
    viteReact(),
  ],
  css: {
    transformer: 'postcss',
    modules: {
      scopeBehaviour: 'local',
      localsConvention: 'camelCaseOnly',
      exportGlobals: true,
      hashPrefix: 'vef',
    },
  },
  build: {
    assetsInlineLimit: 10240,
    reportCompressedSize: false,
    chunkSizeWarningLimit: 2048,
    minify: true,
    cssMinify: true,
    sourcemap: false,
    // rollupOptions: {
    //   output: {
    //     advancedChunks: {
    //       groups: [
    //         {
    //           name: "react",
    //           test: /react(?:-dom)?/,
    //         },
    //         {
    //           name: "vender",
    //         },
    //       ],
    //     },
    //   },
    // },
  },
})
