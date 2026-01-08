#if !os(WASI)

import CSSBuilder
import DesignTokens
import HTMLBuilder
import WebTypes

/// Dashboard content component for administrator panel.
/// Use with WebAdministrator.LayoutView for the full page.
public struct DashboardView: HTML {
	public struct Article: Sendable {
		public let id: String
		public let title: String
		public let slug: String
		public let published: Bool
		public let createdAt: String
		public let updatedAt: String

		public init(
			id: String,
			title: String,
			slug: String,
			published: Bool,
			createdAt: String,
			updatedAt: String
		) {
			self.id = id
			self.title = title
			self.slug = slug
			self.published = published
			self.createdAt = createdAt
			self.updatedAt = updatedAt
		}
	}

	let articles: [Article]
	let contentPath: String

	public init(articles: [Article], contentPath: String = "articles") {
		self.articles = articles
		self.contentPath = contentPath
	}

	public func render(indent: Int = 0) -> String {
		div {
			// Header
			header {
				h1 { "Content" }
					.style {
						fontFamily(typographyFontSerif)
						fontSize(px(32))
						fontWeight(.normal)
						color(colorBase)
					}

				a { "+ New" }
					.href("/administrator/\(contentPath)/new")
					.style {
						padding(spacing12, spacing24)
						fontFamily(typographyFontSans)
						fontSize(fontSizeMedium16)
						fontWeight(500)
						color(colorInverted)
						backgroundColor(backgroundColorProgressive)
						border(.none)
						borderRadius(borderRadiusBase)
						textDecoration(.none)
						display(.inlineBlock)
						transition(.backgroundColor, transitionDurationBase, transitionTimingFunctionSystem)
						
						pseudoClass(.hover) {
							backgroundColor(backgroundColorProgressiveHover)
						}
						
						pseudoClass(.active) {
							backgroundColor(backgroundColorProgressiveActive)
						}
					}
			}
			.style {
				display(.flex)
				justifyContent(.spaceBetween)
				alignItems(.center)
				marginBottom(spacing32)
			}

			// Articles table or empty state
			if articles.isEmpty {
				div {
					div { "No content yet" }
						.style {
							fontFamily(typographyFontSerif)
							fontSize(fontSizeLarge18)
							marginBottom(spacing8)
						}

					div { "Create your first content to get started" }
				}
				.style {
					textAlign(.center)
					padding(spacing48, spacing24)
					color(colorSubtle)
				}
			} else {
				table {
					thead {
						tr {
							th { "Title" }
							th { "Slug" }
							th { "Status" }
							th { "Created" }
							th { "Updated" }
							th { "Actions" }
						}
						.style {
							child("th") {
								textAlign(.left)
								padding(spacing16)
								fontFamily(typographyFontSans)
								fontSize(fontSizeSmall14)
								fontWeight(600)
								color(colorSubtle)
								backgroundColor(backgroundColorNeutralSubtle)
								borderBottom(borderWidthBase, borderStyleBase, borderColorBase)
							}
						}
					}

					tbody {
						for article in articles {
							tr {
								td { article.title }
								td { code { article.slug } }
								td {
									span { article.published ? "Published" : "Draft" }
										.style {
											display(.inlineBlock)
											padding(px(4), spacing8)
											fontSize(fontSizeSmall14)
											borderRadius(borderRadiusSharp)
											backgroundColor(article.published ? backgroundColorSuccessSubtle : backgroundColorWarningSubtle)
											color(article.published ? colorSuccess : colorWarning)
										}
								}
								td { article.createdAt }
								td { article.updatedAt }
								td {
									div {
										a { "Edit" }
											.href("/administrator/\(contentPath)/\(article.id)/edit")
											.style {
												padding(spacing8, spacing12)
												fontSize(fontSizeSmall14)
												color(colorProgressive)
												textDecoration(.none)
												border(borderWidthBase, borderStyleBase, borderColorBase)
												borderRadius(borderRadiusBase)
												transition(.backgroundColor, transitionDurationBase, transitionTimingFunctionSystem)
												
												pseudoClass(.hover) {
													backgroundColor(backgroundColorInteractive)
												}
											}

										a { "View" }
											.href("/\(contentPath)/\(article.slug)")
											.target(.blank)
											.style {
												padding(spacing8, spacing12)
												fontSize(fontSizeSmall14)
												color(colorProgressive)
												textDecoration(.none)
												border(borderWidthBase, borderStyleBase, borderColorBase)
												borderRadius(borderRadiusBase)
												transition(.backgroundColor, transitionDurationBase, transitionTimingFunctionSystem)
												
												pseudoClass(.hover) {
													backgroundColor(backgroundColorInteractive)
												}
											}

										a { "Delete" }
											.href("/administrator/\(contentPath)/\(article.id)/delete")
											.class("dashboard-delete-action")
											.style {
												padding(spacing8, spacing12)
												fontSize(fontSizeSmall14)
												color(colorDestructive)
												textDecoration(.none)
												border(borderWidthBase, borderStyleBase, borderColorBase)
												borderRadius(borderRadiusBase)
												transition(.backgroundColor, transitionDurationBase, transitionTimingFunctionSystem)
												
												pseudoClass(.hover) {
													backgroundColor(backgroundColorErrorSubtle)
												}
											}
									}
									.style {
										display(.flex)
										gap(spacing8)
									}
								}
							}
							.style {
								child("td") {
									padding(spacing16)
									fontFamily(typographyFontSans)
									fontSize(fontSizeMedium16)
									color(colorBase)
									borderBottom(borderWidthBase, borderStyleBase, borderColorBase)
								}
							}
						}
					}
				}
				.style {
					width(perc(100))
					borderCollapse(.collapse)
					backgroundColor(backgroundColorBase)
					border(borderWidthBase, borderStyleBase, borderColorBase)
					borderRadius(borderRadiusBase)
				}
			}
		}
		.class("dashboard-content")
		.style {
			maxWidth(px(1280))
			margin(0, .auto)
			padding(spacing48, spacing24)
		}
		.render(indent: indent)
	}
}

#endif

#if os(WASI)

import WebAPIs
import EmbeddedSwiftUtilities

public class DashboardHydration: @unchecked Sendable {
	private var deleteLinks: [Element] = []

	public init() {
		hydrateDeleteActions()
	}

	public func hydrate() {
		hydrateDeleteActions()
	}

	private func hydrateDeleteActions() {
		let links = document.querySelectorAll(".dashboard-delete-action")

		for link in links {
			deleteLinks.append(link)
			_ = link.on(.click) { event in
				let confirmed = globalThis.confirm("Are you sure you want to delete this?")
				if !confirmed {
					event.preventDefault()
				}
			}
		}
	}
}

#endif
