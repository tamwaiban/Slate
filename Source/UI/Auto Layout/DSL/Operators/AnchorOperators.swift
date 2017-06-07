//
//  AnchorOperators.swift
//  Slate
//
//  Created by John Coates on 6/6/17.
//  Copyright © 2017 John Coates. All rights reserved.
//

import UIKit

// MARK: - Assignment

infix operator -->: LayoutAssignment
precedencegroup LayoutAssignment {
    lowerThan: AdditionPrecedence
    higherThan: AssignmentPrecedence
}

func --> (lhs: Anchor<XAxis>, rhs: Anchor<XAxis>) {
    lhs.pin(to: rhs)
}

func --> (lhs: Anchor<YAxis>, rhs: Anchor<YAxis>) {
    lhs.pin(to: rhs)
}

func --> (lhs: Anchor<Dimension>, rhs: Anchor<Dimension>) {
    lhs.pin(to: rhs)
}

func --> (lhs: DimensionAnchor, rhs: CGFloat) {
    lhs.pin(to: rhs)
}

func --> (lhs: XYAnchor, rhs: XYAnchor) {
    lhs.pin(to: rhs)
}

func --> (lhs: SizeAnchor, rhs: SizeAnchor) {
    lhs.pin(to: rhs)
}

func --> (lhs: EdgesAnchor, rhs: EdgesAnchor) {
    lhs.pin(to: rhs)
}

// MARK: - Greater Than Or Equal To

infix operator -->+=: LayoutAtLeastAssignment
precedencegroup LayoutAtLeastAssignment {
    lowerThan: AdditionPrecedence
    higherThan: AssignmentPrecedence
}

func -->+= (lhs: Anchor<XAxis>, rhs: Anchor<XAxis>) {
    lhs.pin(atLeast: rhs)
}

func -->+= (lhs: Anchor<YAxis>, rhs: Anchor<YAxis>) {
    lhs.pin(atLeast: rhs)
}

func -->+= (lhs: DimensionAnchor, rhs: DimensionAnchor) {
    lhs.pin(atLeast: rhs)
}

func -->+= (lhs: DimensionAnchor, rhs: CGFloat) {
    lhs.pin(atLeast: rhs)
}

func -->+= (lhs: XYAnchor, rhs: XYAnchor) {
    lhs.pin(atLeast: rhs)
}

func -->+= (lhs: SizeAnchor, rhs: SizeAnchor) {
    lhs.pin(atLeast: rhs)
}

func -->+= (lhs: EdgesAnchor, rhs: EdgesAnchor) {
    lhs.pin(atLeast: rhs)
}

// MARK: - Less Than Or Equal To

infix operator -->-=: LayoutAtMostAssignment
precedencegroup LayoutAtMostAssignment {
    lowerThan: AdditionPrecedence
    higherThan: AssignmentPrecedence
}

func -->-= (lhs: Anchor<XAxis>, rhs: Anchor<XAxis>) {
    lhs.pin(atMost: rhs)
}

func -->-= (lhs: Anchor<YAxis>, rhs: Anchor<YAxis>) {
    lhs.pin(atMost: rhs)
}

func -->-= (lhs: DimensionAnchor, rhs: DimensionAnchor) {
    lhs.pin(atMost: rhs)
}

func -->-= (lhs: DimensionAnchor, rhs: CGFloat) {
    lhs.pin(atMost: rhs)
}

func -->-= (lhs: XYAnchor, rhs: XYAnchor) {
    lhs.pin(atMost: rhs)
}

func -->-= (lhs: SizeAnchor, rhs: SizeAnchor) {
    lhs.pin(atMost: rhs)
}

func -->-= (lhs: EdgesAnchor, rhs: EdgesAnchor) {
    lhs.pin(atMost: rhs)
}
