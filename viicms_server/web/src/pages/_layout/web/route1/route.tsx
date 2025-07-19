import { createFileRoute } from '@tanstack/react-router'

export const Route = createFileRoute('/_layout/web/route1')({
  component: RouteComponent,
})

function RouteComponent() {
  return <div>Route1 Page!</div>
}
