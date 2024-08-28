FROM node:20 as base
ENV PORT=8000
EXPOSE 8000


FROM base as dependencies
WORKDIR /app
COPY package*.json .
RUN npm install


FROM base as builder
WORKDIR /app
COPY --from=dependencies /app/node_modules ./node_modules
COPY . .

ENV NEXT_PRIVATE_STANDALONE=true
RUN npm run build


FROM base
WORKDIR /app

ENV NODE_ENV=production

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --gid 1001 --uid 1001 nextjs

COPY --from=builder /app/public ./public
# https://nextjs.org/docs/advanced-features/output-file-tracing
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs

CMD HOSTNAME=localhost node server.js
