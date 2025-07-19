import { createFileRoute, Navigate } from '@tanstack/react-router'

/// 首页重定向 => /web
export const Route = createFileRoute('/')({
  component: () => <Navigate to="/web" />,
})
