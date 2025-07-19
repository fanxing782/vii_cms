import { createFileRoute } from '@tanstack/react-router'

export const Route = createFileRoute('/_layout/web/route2')({
  component: RouteComponent,
})

function RouteComponent() {
  return <div>Route2 Page!</div>
}
