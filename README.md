# `npm run build` does not produce `standalone` directory for next.js@14

## Build

```docker compose build```

## Open bash to nextjs container

```docker compose run -it --rm nextjs-demo bash```

## Result
As you can see ```npm run build``` did not generate `/app/.next/standalone` directory.

`next.config.js` has `output: 'standalone'` and there is env variable `NEXT_PRIVATE_STANDALONE=true`

