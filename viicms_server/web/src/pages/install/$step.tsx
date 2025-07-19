import { createFileRoute } from '@tanstack/react-router'

export const Route = createFileRoute('/install/$step')({
  loader: async ({ params: { step } }) => step,
  component: RouteComponent,
})

function RouteComponent() {
  const step = Route.useLoaderData()

  return <div>Step {step}</div>
}
