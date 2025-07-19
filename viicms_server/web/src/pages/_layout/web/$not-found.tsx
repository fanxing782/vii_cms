import { createFileRoute } from '@tanstack/react-router'

export const Route = createFileRoute('/_layout/web/$not-found')({
  component: WebNotFoundPage,
})

/**
 * web中的404页面
 */
function WebNotFoundPage() {
  return <div>Not Found :( </div>
}
