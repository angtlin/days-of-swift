//
//  MoviesManager.swift
//  StickySectionHeaders
//
//  Created by Angela Lin on 1/24/17.
//  Copyright © 2017 Angela Lin. All rights reserved.
//

import Foundation

class MoviesManager {
    
    func getMovieDataFromJson() -> [Movie] {
        
        var moviesArray = [Movie]()
        
        let url = Bundle.main.url(forResource: "movies", withExtension: "json")
        guard let dataUrl = url else {
            fatalError()
        }
        do {
            let data = try NSData(contentsOf: dataUrl, options: .mappedIfSafe)
            
            do {
                
                if let results = try JSONSerialization.jsonObject(with: data as Data) as? [String:AnyObject],
                    let movieResults = results["movies"] as? [[String:AnyObject]] {
                    
                    for movie in movieResults {
                        if let title = movie["title"] as? String {
                            moviesArray.append(Movie(title: title))
                        }
                    }
                    
                    return moviesArray
                }
                
            } catch {
                print("error1: \(error)")
            }
            
        } catch {
            print("error2: \(error)")
        }
        return moviesArray
    }
    
    
}
