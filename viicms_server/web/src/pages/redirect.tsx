import { redirect, createFileRoute } from '@tanstack/react-router'

/// 登录页重定向 => /login
export const Route = createFileRoute('/redirect')({
  beforeLoad: async () => {
    throw redirect({
      to: '/login',
    })
  },
})
