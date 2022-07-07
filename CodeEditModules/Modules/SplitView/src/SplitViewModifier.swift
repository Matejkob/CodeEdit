//
//  SplitViewModifier.swift
//  CodeEditModules/SplitView
//
//  Created by Mateusz Bąk on 2022/07/07.
//

import SwiftUI

struct SplitViewModifier: ViewModifier {
    let availablePositions: [SplitViewProposalDropPosition]
    @Binding var proposalPosition: SplitViewProposalDropPosition?
    let margin: CGFloat

    func body(content: Content) -> some View {
        GeometryReader { geometryProxy in
            ZStack {
                content
                    .onDrop(
                        of: ["public.file-url"],
                        delegate: SplitViewDropDelegate(
                            availablePositions: availablePositions,
                            proposalPosition: $proposalPosition,
                            geometryProxy: geometryProxy,
                            margin: margin
                        )
                    )

                if let proposalPosition = proposalPosition {
                    SplitViewDropProposalOverlay(
                        proposalPosition: proposalPosition
                    )
                }
            }
        }
    }
}

extension View {
    /// Description
    ///
    /// - Parameters:
    ///   - availablePositions: availablePositions description
    ///   - proposalPosition: proposalPosition description
    ///   - margin: margin description
    ///
    /// - Returns: description
    public func splitView(
        availablePositions: [SplitViewProposalDropPosition],
        proposalPosition: Binding<SplitViewProposalDropPosition?>,
        margin: CGFloat
    ) -> some View {
        modifier(
            SplitViewModifier(
                availablePositions: availablePositions,
                proposalPosition: proposalPosition,
                margin: margin
            )
        )
    }
}
